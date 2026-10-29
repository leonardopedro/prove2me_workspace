-- Generated from ChapterDirectSumEsa.lean — solution of BookProof.DirectSumEsa.fockCore_dense
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
import Theorems.Thm_BookProof_DirectSumEsa_dsCore_dense
import Theorems.Thm_BookProof_NavierStokesFlow_FockContinuum_boundedEnergyCore_dense
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesFockContinuum
open BookProof.DirectSumEsa



open scoped ENNReal


open BookProof.FarisLavine
open BookProof.NavierStokesFlow.FockContinuum

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]
variable {D : ∀ i, Submodule ℂ (G i)}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

private theorem sectorEnergy_measurable {w : ℝ → ℝ} (hw : Measurable w) (n : ℕ) :
    Measurable (sectorEnergy w n) :=
  Finset.univ.measurable_sum fun k _ => hw.comp (measurable_pi_apply k)

set_option maxHeartbeats 1000000 in

theorem solution {w : ℝ → ℝ} (hw : Measurable w) :
    Dense ((fockCore w : Submodule ℂ fockSpace) : Set fockSpace) :=
  dsCore_dense (fun n => boundedEnergyCore_dense _ (sectorEnergy_measurable hw n))
