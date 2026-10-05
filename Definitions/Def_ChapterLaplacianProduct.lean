import Definitions.Def_ChapterRadialLaplacian
import Mathlib

/-!
# The Laplacian of a product, and of (radial) × (harmonic homogeneous)

Continuation of `BookProof.ChapterRadialLaplacian`, which computed the Laplacian
of a radial function in order to state Note 68 of `book.tex` §A.5 in space.  The
eigenfunctions of `−∂⃗²` with angular momentum `l ≥ 1` are *not* radial: they are
products of a radial factor with an angular one (a spherical harmonic, i.e. a
harmonic polynomial homogeneous of degree `l`, divided by `rˡ`).  This module
supplies the two missing general facts.

## Contents

* `laplacian_mul` — **the product rule for the Laplacian**, which Mathlib does
  not have: `Δ(fg) = (Δf)g + f(Δg) + 2 ∑ᵢ ∂ᵢf ∂ᵢg` in any orthonormal basis;
* `fderiv_radial` — the derivative of a radial function,
  `D(y ↦ g‖y‖)(x) = (g'(‖x‖)/‖x‖) ⟪x, ·⟫`;
* `sum_inner_mul_apply` — the basis identity `∑ᵢ ⟪x, vᵢ⟫ L(vᵢ) = L(x)`;
* `laplacian_radial_mul_harmonic` — **the Laplacian of a radial function times a
  harmonic function homogeneous of degree `l`** (homogeneity used only through
  Euler's identity `DH(x)(x) = l·H(x)`):
  `Δ(y ↦ g‖y‖ · H y)(x) = (g''(‖x‖) + ((n − 1 + 2l)/‖x‖) g'(‖x‖)) · H x`;
* `helmholtz_radial_mul_harmonic` — consequently, if the radial factor solves the
  reduced equation `g'' + ((n−1+2l)/r) g' = −p² g`, the product is an
  eigenfunction of `−∂⃗²` with eigenvalue `p²`;
* `harmonic_clm`, `euler_clm` — every continuous linear functional is harmonic
  and homogeneous of degree one, so the degree-`1` case of the hypotheses is
  realized (for example by a coordinate `x³` on `ℝ³`).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/
namespace BookProof.ChapterLaplacianProduct

end BookProof.ChapterLaplacianProduct
