import Theorems.Thm_BookProof_HermiteProductCore_pgMap_apply

import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterStrichartzWave
import Mathlib


/-!
# Degenerate Schrödinger operators `−Δ_S + W` on `L²(ℝᵈ)`

The Standard-Model Faris–Lavine comparison operator `N = 2h + Σ_m q_m² + c₀` of
`BookProof/ChapterSmFarisLavine.lean` is a Schrödinger operator on `L²(ℝ¹⁶³)` whose kinetic
term differentiates only the `40` momentum-carrying coordinates: it has the shape

`−Δ_S + W`,  `Δ_S = ∑_{j ∈ S} ∂_j²`,

with `S ⊆ {0, …, d−1}` a set of coordinates and `W ≥ 0` a (quartic) polynomial.  This module
sets up that class of operators on the two cores the project works with —

* the **Gauss–polynomial core** `polyGaussCore d`, via the polynomial realization
  `kinPolyS S` of `−Δ_S` (`hamCoreS`);
* the **compactly supported smooth core** `ccDomain (Vd d)` (`ccHamS`) —

records their pointwise formulas and their symmetry, and packages the elementary facts
about polynomial potentials (`polyW`) that the analysis in
`BookProof/ChapterDegKatoEsa.lean` and `BookProof/ChapterHermiteGraphApprox.lean` consumes.

For `S = Finset.univ` everything here specializes to the `−Δ + W` of
`BookProof.QgHermiteFriedrichs` and `BookProof.QgOneParticleCc`.
-/

namespace BookProof.DegSchrodinger

open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis

noncomputable section

variable {d : ℕ}

/-! ## 1. The kinetic term of a set of coordinates -/

/-- The coefficient vector of `−Δ_S`: `−1` in the directions of `S`, `0` elsewhere. -/
def kinCoeff (S : Finset (Fin d)) (j : Fin d) : ℝ := if j ∈ S then -1 else 0

/-- `−Δ_S = −∑_{j ∈ S} ∂_j²` as an operator on Schwartz space. -/
def kinOpS (S : Finset (Fin d)) : 𝓢(Vd d, ℂ) →L[ℂ] 𝓢(Vd d, ℂ) :=
  constCoeffOp (kinCoeff S) (kinDir d) 0

/-- The partial Laplacian in coordinates. -/
def lapCS (S : Finset (Fin d)) (u : Vd d → ℂ) (x : Vd d) : ℂ :=
  ∑ j ∈ S, dcoord j (dcoord j u) x



/-- The kinetic term on the compactly supported smooth core. -/
def kinCcS (S : Finset (Fin d)) : ccDomain (Vd d) →ₗ[ℂ] L2d d :=
  opL2 (kinOpS S) ∘ₗ Submodule.inclusion (ccDomain_le_schwartzDomain (E := Vd d))

/-- **The degenerate Schrödinger operator `−Δ_S + W` on the compactly supported smooth
core** of `L²(ℝᵈ)`, for an arbitrary smooth real potential `W`. -/
def ccHamS (W : Vd d → ℝ) (hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W) (S : Finset (Fin d)) :
    ccDomain (Vd d) →ₗ[ℂ] L2d d :=
  kinCcS S + opCc W hW









/-! ## 2. The kinetic term on the Gauss–polynomial core -/

/-- The polynomial realization of `−Δ_S` on the Gauss–polynomial core. -/
def kinPolyS (S : Finset (Fin d)) (p : MvPolynomial (Fin d) ℂ) : MvPolynomial (Fin d) ℂ :=
  -∑ j ∈ S, coreD j (coreD j p)

theorem kinPolyS_add (S : Finset (Fin d)) (p q : MvPolynomial (Fin d) ℂ) :
    kinPolyS S (p + q) = kinPolyS S p + kinPolyS S q := by
  simp only [kinPolyS, coreD_add, Finset.sum_add_distrib, neg_add]

theorem kinPolyS_smul (S : Finset (Fin d)) (c : ℂ) (p : MvPolynomial (Fin d) ℂ) :
    kinPolyS S (c • p) = c • kinPolyS S p := by
  simp only [kinPolyS, coreD_smul, ← Finset.smul_sum, smul_neg]



/-- `H p = −Δ_S(p e^{−‖x‖²/4}) + W · (p e^{−‖x‖²/4})`, as an element of `L²(ℝᵈ)`. -/
def hamPolyS (W : Vd d → ℝ) (hWc : Continuous W) (hWb : ExpBounded W) (S : Finset (Fin d))
    (p : MvPolynomial (Fin d) ℂ) : L2d d :=
  pgLp (kinPolyS S p) + potLp W hWc hWb p

/-- The operator as a linear map out of the polynomials. -/
def hamPolyMapS (W : Vd d → ℝ) (hWc : Continuous W) (hWb : ExpBounded W) (S : Finset (Fin d)) :
    MvPolynomial (Fin d) ℂ →ₗ[ℂ] L2d d where
  toFun := hamPolyS W hWc hWb S
  map_add' p q := by
    have h : pgLp (kinPolyS S p + kinPolyS S q)
        = pgLp (kinPolyS S p) + pgLp (kinPolyS S q) := by
      rw [← HermiteProductCore.pgMap_apply, ← HermiteProductCore.pgMap_apply,
        ← HermiteProductCore.pgMap_apply, map_add]
    simp only [hamPolyS, kinPolyS_add, potLp_add, h]
    abel
  map_smul' c p := by
    have h : pgLp (c • kinPolyS S p) = c • pgLp (kinPolyS S p) := by
      rw [← HermiteProductCore.pgMap_apply, ← HermiteProductCore.pgMap_apply, map_smul]
    simp only [hamPolyS, kinPolyS_smul, potLp_smul, RingHom.id_apply, h, smul_add]

/-- **The degenerate Schrödinger operator `−Δ_S + W` on the Gauss–polynomial core.** -/
def hamCoreS (W : Vd d → ℝ) (hWc : Continuous W) (hWb : ExpBounded W) (S : Finset (Fin d)) :
    (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  (hamPolyMapS W hWc hWb S).comp (coreEquiv (d := d)).symm.toLinearMap











/-! ## 3. Polynomial potentials -/

/-- The real-valued function attached to a polynomial with real coefficients. -/
def polyW (q : MvPolynomial (Fin d) ℂ) (x : Vd d) : ℝ :=
  (MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) q).re













end

end BookProof.DegSchrodinger
