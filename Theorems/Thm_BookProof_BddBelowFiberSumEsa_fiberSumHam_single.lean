-- Generated from ChapterBddBelowFiberSumEsa.lean — theorem BookProof.BddBelowFiberSumEsa.fiberSumHam_single
import Mathlib
import Definitions.Def_ChapterBddBelowFiberSumEsa
import Definitions.Def_BookProof.ChapterClosureUniqueness

open BookProof.BddBelowFiberSumEsa











open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.BddBelowWallEsa BookProof.WallEsaSemibounded BookProof.DirectSumEsa

noncomputable section

variable {ι : Type*}

theorem BookProof.BddBelowFiberSumEsa.fiberSumHam_single [DecidableEq ι] (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i)) (i : ι) (u : ccDomain ℝ) :
    fiberSumHam V hV ⟨lp.single 2 i (u : Lp ℂ 2 (volume : Measure ℝ)),
        single_mem_dsCore (D := fun _ : ι => ccDomain ℝ) i u⟩
      = lp.single 2 i (wallHam (V i) (hV i) u) := by sorry
