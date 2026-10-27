-- Generated from ChapterL2FibreSum.lean — solution of BookProof.ChapterL2FibreSum.fibreEquiv_proj
import Mathlib
import Definitions.Def_ChapterL2FibreSum
import Theorems.Thm_BookProof_ChapterL2FibreSum_fibreEmb_proj
import Theorems.Thm_BookProof_ChapterHilbertSumIntertwine_linearIsometryEquiv_intertwine
open BookProof.ChapterL2FibreSum



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterHilbertSumIntertwine

variable {X : Type*} [MeasurableSpace X] {μ : Measure X}

variable {X : Type*} [MeasurableSpace X] {μ : Measure X}
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable {ι : Type*} [DecidableEq ι]

set_option maxHeartbeats 1000000 in
theorem solution [Countable ι] (μ : Measure X) {E : Set X} (hE : MeasurableSet E)
    (v : Lp (Fibre ι) 2 μ) (i : ι) :
    fibreEquiv μ (proj μ hE v) i = proj μ hE (fibreEquiv μ v i) :=
  linearIsometryEquiv_intertwine (isHilbertSum_fibreEmb μ) (projCLM μ hE)
      (fun _ : ι => projCLM μ hE) (fun _ u => norm_proj_le μ hE u)
      (fun i u => fibreEmb_proj μ i hE u) v i
