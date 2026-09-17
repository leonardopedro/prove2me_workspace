-- Generated from ChapterBddBelowFiberSumEsa.lean — solution of BookProof.BddBelowFiberSumEsa.fiberSumHam_single
import Mathlib
import Definitions.Def_ChapterBddBelowFiberSumEsa
open BookProof.BddBelowFiberSumEsa












open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.BddBelowWallEsa BookProof.WallEsaSemibounded BookProof.DirectSumEsa

noncomputable section

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution [DecidableEq ι] (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i)) (i : ι) (u : ccDomain ℝ) :
    fiberSumHam V hV ⟨lp.single 2 i (u : Lp ℂ 2 (volume : Measure ℝ)),
        single_mem_dsCore (D := fun _ : ι => ccDomain ℝ) i u⟩
      = lp.single 2 i (wallHam (V i) (hV i) u) := dsOp_single (D := fun _ : ι => ccDomain ℝ) (fun i => wallHam (V i) (hV i)) i u
