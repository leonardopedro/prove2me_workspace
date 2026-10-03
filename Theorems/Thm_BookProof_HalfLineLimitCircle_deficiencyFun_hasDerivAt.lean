-- Generated from ChapterHalfLineLimitCircle.lean — theorem BookProof.HalfLineLimitCircle.deficiencyFun_hasDerivAt
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
import Definitions.Def_ChapterA4



open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

theorem BookProof.HalfLineLimitCircle.deficiencyFun_hasDerivAt (x : ℝ) :
    HasDerivAt deficiencyFun (-lam * deficiencyFun x) x := by sorry
