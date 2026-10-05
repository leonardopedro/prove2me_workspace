-- Generated from ChapterHalfLineLimitCircle.lean — solution of BookProof.HalfLineLimitCircle.hlEquiv_coe
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle




open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

set_option maxHeartbeats 1000000 in
theorem solution (f : testSpace) : ((hlEquiv f : hlCore) : HL) = testIncl f := rfl
