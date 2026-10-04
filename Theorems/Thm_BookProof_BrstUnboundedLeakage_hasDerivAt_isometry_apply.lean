-- Generated from ChapterBrstUnboundedLeakage.lean — theorem BookProof.BrstUnboundedLeakage.hasDerivAt_isometry_apply
import Definitions.Def_ChapterBrstTruncationLeakage
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterBrstUnboundedLeakage
import Definitions.Def_ChapterA4
open BookProof.BrstUnboundedLeakage

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


open NormedSpace Filter Topology
open scoped InnerProductSpace


open BookProof.BrstLeakage BookProof.ChapterStoneResolvent


theorem BookProof.BrstUnboundedLeakage.hasDerivAt_isometry_apply {U : ℝ → H →L[ℂ] H} {f : ℝ → H} {f' : H}
    (hiso : ∀ (h : ℝ) (y : H), ‖U h y‖ = ‖y‖) (hU0 : ∀ y : H, U 0 y = y)
    (hcont : ∀ y : H, Tendsto (fun h : ℝ => U h y) (𝓝 0) (𝓝 y))
    (hf : HasDerivAt f f' 0) (hf0 : f 0 = 0) :
    HasDerivAt (fun h : ℝ => U h (f h)) f' 0 := by sorry
