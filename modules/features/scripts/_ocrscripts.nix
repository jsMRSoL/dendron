{ pkgs, ... }:
let
  ocreng = pkgs.writeShellScriptBin "ocreng" ''
    for image in *.png; do
      echo "converting $image..."
      ${pkgs.imagemagick}/bin/magick "$image" "''${image/.png/.tiff}"
    done

    for tiff in *.tiff; do
      echo "unpapering $tiff..."
      ${pkgs.unpaper}/bin/unpaper "$tiff" "''${tiff/.tiff/.unp}"
      rm "$tiff"
    done

    count=1
    for page in *.unp; do
      echo "performing ocr on $page..."
      no=$(printf "%02d" $count)
      ${pkgs.tesseract}/bin/tesseract "$page" "''${page/.png/$no}" -l eng
      count=$((count + 1))
      rm "$page"
    done

    for file in *.txt; do
      cat "$file" >> binder.txt
      rm "$file"
    done
  '';

  ocrlatin = pkgs.writeShellScriptBin "ocrlatin" ''
    for image in *.png; do
      echo "converting $image..."
      ${pkgs.imagemagick}/bin/magick "$image" "''${image/.png/.tiff}"
    done

    for tiff in *.tiff; do
      echo "unpapering $tiff..."
      ${pkgs.unpaper}/bin/unpaper "$tiff" "''${tiff/.tiff/.unp}"
      rm "$tiff"
    done

    count=1
    for page in *.unp; do
      echo "performing ocr on $page..."
      no=$(printf "%02d" $count)
      ${pkgs.tesseract}/bin/tesseract "$page" "''${page/.unp/_$no}" -l lat+eng
      count=$((count + 1))
      rm "$page"
    done

    for file in *.txt; do
      cat "$file" >> binder.txt
      rm "$file"
    done
  '';

  ocrgreek = pkgs.writeShellScriptBin "ocrgreek" ''
    for image in *.png; do
      echo "converting $image..."
      ${pkgs.imagemagick}/bin/magick "$image" "''${image/.png/.tiff}"
    done

    for tiff in *.tiff; do
      echo "unpapering $tiff..."
      ${pkgs.unpaper}/bin/unpaper "$tiff" "''${tiff/.tiff/.unp}"
      rm "$tiff"
    done

    count=1
    for page in *.unp; do
      echo "performing ocr on $page..."
      no=$(printf "%02d" $count)
      ${pkgs.tesseract}/bin/tesseract "$page" "''${page/.unp/_$no}" -l grc+eng
      count=$((count + 1))
      rm "$page"
    done

    for file in *.txt; do
      cat "$file" >> binder.txt
      rm "$file"
    done
  '';
in
{
  home.packages = [
    ocreng
    ocrgreek
    ocrlatin
  ];
}
