-- Generated from ChapterPvmInducedSystem.lean — solution of BookProof.ChapterPvmInducedSystem.linearIsometryEquiv_swIsom_pvm
import Mathlib
import Definitions.Def_ChapterPvmInducedSystem
import Theorems.Thm_BookProof_ChapterPvmInducedSystem_isHilbertSum_swIsom
import Theorems.Thm_BookProof_ChapterHilbertSumIntertwine_linearIsometryEquiv_intertwine
import Theorems.Thm_BookProof_ChapterPvmCyclicUnitary_swCLM_proj
open BookProof.ChapterPvmInducedSystem



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicUnitary
open BookProof.ChapterPvmCyclicDecomposition BookProof.ChapterMackeyQuasiInvariant
open BookProof.ChapterHilbertSumIntertwine

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution {P : Pvm X H} {S : Set H} (hS : OrthCyclicFamily P S)
    (hdense : Dense ((Submodule.span ℂ (familyOrbit P S) : Submodule ℂ H) : Set H))
    {E : Set X} (hE : MeasurableSet E) (v : H) (ψ : S) :
    (isHilbertSum_swIsom hS hdense).linearIsometryEquiv (P.p E v) ψ
      = proj (pvmMeasure P (ψ : H)) hE
          ((isHilbertSum_swIsom hS hdense).linearIsometryEquiv v ψ) :=
  linearIsometryEquiv_intertwine (isHilbertSum_swIsom hS hdense) (P.p E)
      (fun ψ : S => projL (pvmMeasure P (ψ : H)) hE)
      (fun ψ u => norm_proj_le (pvmMeasure P (ψ : H)) hE u)
      (fun ψ u => swCLM_proj P (ψ : H) hE u) v ψ
