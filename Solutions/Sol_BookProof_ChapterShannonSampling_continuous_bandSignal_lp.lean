-- Generated from ChapterShannonSampling.lean — solution of BookProof.ChapterShannonSampling.continuous_bandSignal_lp
import Mathlib
import Definitions.Def_ChapterShannonSampling
import Theorems.Thm_BookProof_ChapterShannonSampling_integrableOn_spectrum
import Theorems.Thm_BookProof_ChapterShannonSampling_continuous_bandSignal
open BookProof.ChapterShannonSampling




open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

variable {T : ℝ} [hT : Fact (0 < T)]

set_option maxHeartbeats 1000000 in
theorem solution (F : Lp ℂ 2 (haarAddCircle (T := T))) :
    Continuous (bandSignal (T := T) (F : AddCircle T → ℂ)) := continuous_bandSignal _ (integrableOn_spectrum F)
