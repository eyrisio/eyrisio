{
	description = "My portfolio";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
		systems.url = "github:nix-systems/default";
	};

	outputs = { self, nixpkgs, systems }:
	let
		forEachSys = nixpkgs.lib.genAttrs ( import systems );
	in {
		devShells = forEachSys (
			system:
			let
				pkgs = import nixpkgs { inherit system; };
			in {
				default = pkgs.mkShell {
					nativeBuildInputs = with pkgs; [
						bun
					];
				};
			}
		);
	};
}
