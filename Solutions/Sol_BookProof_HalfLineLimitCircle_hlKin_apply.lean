-- Generated from ChapterHalfLineLimitCircle.lean — solution of BookProof.HalfLineLimitCircle.hlKin_apply
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
open BookProof.HalfLineLimitCircle




open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

set_option maxHeartbeats 1000000 in
theorem solution (f : testSpace) : hlKin (hlEquiv f) = -testIncl (deriv2LM f) := by

  simp [hlKin]
