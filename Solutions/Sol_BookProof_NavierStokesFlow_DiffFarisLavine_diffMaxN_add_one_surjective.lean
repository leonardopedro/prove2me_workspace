-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.diffMaxN_add_one_surjective
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxEquiv_coe
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxN_apply
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_add_one_surjective
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine





open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat BookProof.FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (mu : ℝ) (hmu : 0 ≤ mu) (f : L2d 3) :
    ∃ z : diffMaxDom mu, diffMaxN mu z + (z : L2d 3) = f := by

  obtain ⟨x, hx⟩ := diagMax_add_one_surjective (velSym mu)
    (fun β => le_trans zero_le_one (velSym_ge_one hmu β)) (velUnitary.symm f)
  refine ⟨diffMaxEquiv mu x, ?_⟩
  rw [diffMaxN_apply, diffMaxEquiv_coe, ← map_add, hx]
  simp
