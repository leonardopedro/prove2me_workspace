-- Generated from ChapterDirectSumEsa.lean — theorem BookProof.DirectSumEsa.dsOp_single
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
import Theorems.Thm_BookProof_DirectSumEsa_single_mem_dsCore
open BookProof.DirectSumEsa


open scoped ENNReal


open BookProof.FarisLavine

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]

variable {D : ∀ i, Submodule ℂ (G i)}

theorem BookProof.DirectSumEsa.dsOp_single [DecidableEq ι] (H : ∀ i, D i →ₗ[ℂ] G i) (i : ι) (u : D i) :
    (dsOp H ⟨lp.single 2 i ((u : G i)), single_mem_dsCore i u⟩ : lp G 2)
      = lp.single 2 i (H i u) := by sorry
