-- Generated from ChapterHalfLineLimitCircle.lean — theorem BookProof.HalfLineLimitCircle.hlEquiv_coe
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
import Definitions.Def_ChapterA4



open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

theorem BookProof.HalfLineLimitCircle.hlEquiv_coe (f : testSpace) : ((hlEquiv f : hlCore) : HL) = testIncl f := by sorry
