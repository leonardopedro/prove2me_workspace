-- Generated from ChapterDirectSumEsa.lean — solution of BookProof.DirectSumEsa.fockH_isSymmetricDom
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
import Theorems.Thm_BookProof_DirectSumEsa_dsOpD_isSymmetricDom
import Theorems.Thm_BookProof_NavierStokesFlow_FockContinuum_multOp_isSymmetricDom
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_IsSymmetricDom_sub
open BookProof.DirectSumEsa



open scoped ENNReal


open BookProof.FarisLavine
open BookProof.ChapterLinftyMultiplication
open BookProof.NavierStokesFlow.FockContinuum
open BookProof.NavierStokesFlow.FullEsa
open BookProof.NavierStokesFlow.FullEsa.NSFullData

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]
variable {D : ∀ i, Submodule ℂ (G i)}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in

theorem solution {w : ℝ → ℝ} (hw : Measurable w) :
    FullEsa.IsSymmetricDom (fockH hw) :=
  dsOpD_isSymmetricDom _ (fun n => multOp_isSymmetricDom _ (sectorEnergy_measurable hw n))
