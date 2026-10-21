-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.nsDiffH_commForm_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_embedCore_surjective
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_quadForm_nsDiffN_embedCore
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_commForm_embedCore
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
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
    ∃ cst : ℝ, 0 ≤ cst ∧ ∀ f : polyGaussCore (d := 3),
      |commForm ((polyGaussCore (d := 3)).subtype.comp (nsDiffH A c))
          ((polyGaussCore (d := 3)).subtype.comp (nsDiffN (diffMu A c))) f|
        ≤ cst * quadForm ((polyGaussCore (d := 3)).subtype.comp (nsDiffN (diffMu A c))) f := by

  obtain ⟨cst, hcst, hbound⟩ :=
    SignedShift.listH_commForm_bound (hopList A (seqConst c))
      (fun β => velSym_ge_one (velMu_nonneg A (seqConst c)) β)
  refine ⟨cst, hcst, fun f => ?_⟩
  obtain ⟨x, rfl⟩ := embedCore_surjective f
  simp only [diffMu]
  rw [commForm_embedCore, quadForm_nsDiffN_embedCore]
  exact hbound _
