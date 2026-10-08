-- Generated from ChapterDirectSumEsa.lean — theorem BookProof.DirectSumEsa.fockCore_dense
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterNavierStokesFockContinuum
open BookProof.NavierStokesFlow.FockContinuum
open BookProof.DirectSumEsa


open scoped ENNReal


open BookProof.FarisLavine

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]

variable {D : ∀ i, Submodule ℂ (G i)}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.DirectSumEsa.fockCore_dense {w : ℝ → ℝ} (hw : Measurable w) :
    Dense ((fockCore w : Submodule ℂ fockSpace) : Set fockSpace) := by sorry
