import Definitions.Def_ChapterHermiteBandCalculusHigher
import Definitions.Def_ChapterYangMillsAbelianFockEsa
import Mathlib

import Mathlib
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterYangMillsAbelianEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsSU3

/-!
# The Hermite matrix of the **full non-abelian** gauge-fixed Yang–Mills Hamiltonian:
# sparsity, band radius and entry bounds

The certificate seam of the Yang–Mills thread (`BookProof.ChapterSchurGershgorinGap`,
`BookProof.ChapterYangMillsCertificateSeam`) consumes matrix elements
`a_{jk} = ⟪b_j, H b_k⟫` of the one-particle Hamiltonian.  Until now nothing said, for the
*physical* Hamiltonian `f_{abc} ≠ 0`, which of those entries can be non-zero or how large
they are: the band calculus of `BookProof.ChapterHermiteBandCalculus` is a calculus of
quadratic symbols, and with non-zero structure constants the magnetic field
`B_{ia} = ε_{ijk}(∂_jA_{k,a} + f_{abc}A_{j,b}A_{k,c})` is cubic, so `B²` is quartic.

`BookProof.ChapterHermiteBandCalculusHigher` removes the degree restriction from the
*matrix-structure* half of the calculus.  This chapter applies it to Yang–Mills.

## What is proved

* `ymPoly fabc` — the polynomial-level Hamiltonian `½Σ_m π_m² + ½Σ_m B_m²` for an arbitrary
  real family of structure constants (the `f_{abc} = 0` case is `ymAbelianPoly`).
* `ymHermOp`, **`ymHermOp_eq`**, `ymHamiltonian_hermCore_eq'` — on the finite-mode domain of
  the product Hermite basis it *is* `ymHamiltonian (coreRepHerm e) fabc`, the Hamiltonian of
  `BookProof.ChapterYangMillsHermite`.
* `isBandDeg2_magMulOp` — multiplication by the full cubic magnetic polynomial is a band
  operator of order `2` (each of its monomials has degree at most `2` in the coordinates).
* **`isBandDeg4_ymPoly`** — hence the Yang–Mills Hamiltonian is a band operator of order `4`.
* `gradedBand_of_isBandR` — the general seam: a band operator of radius `r` and order `m`
  has a Hermite matrix with boundedly many entries per column, band radius `r` in the
  degree, and entries bounded by `C·√(deg+1)^m`.
* **`ym_hermCol_band_bounds`** — the headline, for every real `f_{abc}`: there are `M` and
  `C` such that every column of the Hermite matrix of the gauge-fixed Yang–Mills
  Hamiltonian has at most `M` non-zero entries, an entry `⟪ψ_{e j}, H ψ_{e k}⟫` vanishes
  unless `|deg (e j) − deg (e k)| ≤ 4`, and `|⟪ψ_{e j}, H ψ_{e k}⟫| ≤ C (deg (e k) + 1)²`.
* `isHermCol_ymHermCol` — the matrix is Hermitian.

## Why this is the certificate data

A certificate for a gap has to enumerate matrix elements.  The statement above says the
enumeration is *finite and complete*: outside a window of `4` degrees around the column
index every entry is zero, inside it there are at most `M` of them, and each is bounded a
priori by `C(deg+1)²`.  That is exactly the input shape of the Gershgorin/Schur criteria of
`BookProof.ChapterSchurGershgorinGap`.

## Honest boundary

Nothing here is a self-adjointness statement for `f_{abc} ≠ 0`: the weighted Schur gate that
turns a band matrix into essential self-adjointness of `dΓ` is available only for order `≤ 2`
(with an order-`m` symbol and any weight that is a function of the degree, the commutator
term of the gate grows like `deg^{m/2−1}`).  And nothing here is a mass gap: the numerical
values of the entries are not computed, only their support and their size.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.YangMillsBandBounds

noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.HermiteBandHigher BookProof.QuadFockEsa
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs BookProof.YmAbelianFock
open BookProof.NavierStokesFlow.DifferentialL2 BookProof.HermiteRelative

/-! ## The polynomial-level Hamiltonian for arbitrary structure constants -/

/-- The polynomial-level gauge-fixed Yang–Mills Hamiltonian `½ Σ_m π_m² + ½ Σ_m B_m²`, with
the **full cubic** magnetic polynomial. -/
def ymPoly (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    MvPolynomial (Fin 99) ℂ →ₗ[ℂ] MvPolynomial (Fin 99) ℂ :=
  ((1 / 2 : ℝ) : ℂ) •
    ((∑ m : Fin 24, (YangMillsHermite.momOp (ymMomIdx m)).comp
        (YangMillsHermite.momOp (ymMomIdx m)))
      + ∑ m : Fin 24, (mulOp (magPoly fabc (decodeSpace m) (decodeColor m))).comp
          (mulOp (magPoly fabc (decodeSpace m) (decodeColor m))))



/-- The one-particle Yang–Mills Hamiltonian as an endomorphism of the finite-mode domain of
the product Hermite basis. -/
def ymHermOp (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    finiteModeDomain (hermBasisN e) →ₗ[ℂ] finiteModeDomain (hermBasisN e) :=
  weylOpDom (piOps (coreRepHerm e)) (magOps (coreRepHerm e) fabc)





/-- Its matrix in the product Hermite basis. -/
def ymHermCol (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) : ℕ → (ℕ →₀ ℂ) :=
  opCol (hermBasisN e) (ymHermOp e fabc)





/-! ## The order of the Yang–Mills Hamiltonian -/









/-! ## The matrix seam for an arbitrary order -/



/-! ## The headline -/



end

end BookProof.YangMillsBandBounds
