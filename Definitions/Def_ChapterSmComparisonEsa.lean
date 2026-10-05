import Definitions.Def_ChapterHermiteGraphApprox
import Definitions.Def_ChapterSmFarisLavine
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsHermite
import Mathlib


/-!
# The Standard-Model Faris–Lavine comparison operator is essentially self-adjoint

`BookProof/ChapterSmFarisLavine.lean` proves both Faris–Lavine inequalities for the pair
`(h, N)`, `N = 2h + Σ_m q_m² + c₀`, and reduces essential self-adjointness of the
Standard-Model one-particle Hamiltonian `h` on the Gauss–polynomial core of `L²(ℝ¹⁶³)` to
essential self-adjointness of `N` on the same core (`sm_h_esa_of_comparison_esa`).  That
remaining input is a Kato-type theorem for a Schrödinger operator with a coupled quartic
potential, which the Faris–Lavine criterion structurally cannot supply.

This module supplies it, and thereby removes the hypothesis:

* `smFlN_eq_hamCoreS` — on the core, `N = 2h + Σ_m q_m² + c₀` *is* the degenerate
  Schrödinger operator `−Δ_S + W` of `BookProof.DegSchrodinger`, with `S` the 40
  momentum-carrying coordinates and `W = Σ_r Φ_r² + Σ_m q_m² + c₀` a non-negative polynomial
  of degree four;
* `smFlN_esa` — hence `N` is essentially self-adjoint on the Gauss–polynomial core, by the
  Kato theorem of `BookProof.DegKatoEsa` and the Hermite graph approximation of
  `BookProof.HermiteGraphApprox`;
* **`sm_h_esa`** — hence so is the Standard-Model one-particle Hamiltonian itself.
-/

namespace BookProof.SmComparisonEsa

open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmFarisLavine

noncomputable section

/-! ## 1. Transport of polynomial operators to the core, in coordinates -/







/-! ## 2. The data of the comparison operator as a degenerate Schrödinger operator -/

/-- The 40 momentum-carrying coordinates of the Standard-Model field space. -/
def smS : Finset (Fin 163) := Finset.image smCoord Finset.univ

/-- The `r`-th field polynomial of the Standard-Model Hamiltonian. -/
def smPhi (P : SmParams) (r : Fin 49) : MvPolynomial (Fin 163) ℂ :=
  smFormPoly P (id : Fin 163 → Fin 163) (smFormFin.symm r)



/-- The potential of the comparison operator: `W = Σ_r Φ_r² + Σ_m q_m² + c₀`. -/
def smPotPoly (P : SmParams) (c0 : ℝ) : MvPolynomial (Fin 163) ℂ :=
  (∑ r : Fin 49, smPhi P r * smPhi P r) + smQPoly + C ((c0 : ℝ) : ℂ)









/-! ## 3. The comparison operator is `−Δ_S + W` -/









/-! ## 4. Essential self-adjointness -/







end

end BookProof.SmComparisonEsa
