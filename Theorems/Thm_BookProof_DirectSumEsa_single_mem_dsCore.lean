-- Generated from ChapterDirectSumEsa.lean — theorem BookProof.DirectSumEsa.single_mem_dsCore
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
open BookProof.DirectSumEsa


open scoped ENNReal


open BookProof.FarisLavine

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]

variable {D : ∀ i, Submodule ℂ (G i)}

theorem BookProof.DirectSumEsa.single_mem_dsCore [DecidableEq ι] (i : ι) (u : D i) :
    (lp.single 2 i ((u : G i)) : lp G 2) ∈ dsCore D := by sorry
