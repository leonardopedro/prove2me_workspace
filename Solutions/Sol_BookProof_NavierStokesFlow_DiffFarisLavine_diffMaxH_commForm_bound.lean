-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.diffMaxH_commForm_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxEquiv_coe
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxN_apply
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxH_apply
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_listH_commForm_bound
import Theorems.Thm_velMu_nonneg
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine





open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat BookProof.FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ cst : ℝ, 0 ≤ cst ∧ ∀ z : diffMaxDom (velMu A (seqConst c)),
      |commForm (diffMaxH A c) (diffMaxN (velMu A (seqConst c))) z|
        ≤ cst * quadForm (diffMaxN (velMu A (seqConst c))) z := by

  obtain ⟨cst, hcst, hbound⟩ :=
    SignedShift.listH_commForm_bound (hopList A (seqConst c))
      (fun β => velSym_ge_one (velMu_nonneg A (seqConst c)) β)
  refine ⟨cst, hcst, fun z => ?_⟩
  obtain ⟨z', rfl⟩ := (diffMaxEquiv (velMu A (seqConst c))).surjective z
  have hcomm : commForm (diffMaxH A c) (diffMaxN (velMu A (seqConst c)))
        (diffMaxEquiv (velMu A (seqConst c)) z')
      = commForm (velH A (seqConst c)) (diagMax (velSym (velMu A (seqConst c)))) z' := by
    simp only [commForm]
    rw [diffMaxH_apply, diffMaxN_apply, velUnitary.inner_map_map, velUnitary.inner_map_map]
  have hquad : quadForm (diffMaxN (velMu A (seqConst c)))
        (diffMaxEquiv (velMu A (seqConst c)) z')
      = quadForm (diagMax (velSym (velMu A (seqConst c)))) z' := by
    simp only [quadForm]
    rw [diffMaxN_apply, diffMaxEquiv_coe, velUnitary.inner_map_map]
  rw [hcomm, hquad]
  exact hbound z'
