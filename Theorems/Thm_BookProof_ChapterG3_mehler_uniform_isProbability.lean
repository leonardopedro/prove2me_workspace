-- Generated from ChapterG3.lean — theorem BookProof.ChapterG3.mehler_uniform_isProbability
import Mathlib
import Definitions.Def_ChapterG3
import Definitions.Def_ChapterG3Promoted
open BookProof.ChapterG3


open MeasureTheory
open scoped ENNReal



variable {X : Type*}


theorem BookProof.ChapterG3.mehler_uniform_isProbability (k : ℕ) :
    IsProbabilityMeasure (PhysHSGaussian.sphereUniform k) := by sorry
