-- Generated from ChapterG3.lean — theorem BookProof.ChapterG3.mehler_uniform_concentrates
import Mathlib
import Definitions.Def_ChapterG3
open BookProof.ChapterG3


open MeasureTheory
open scoped ENNReal



variable {X : Type*}


theorem BookProof.ChapterG3.mehler_uniform_concentrates (k : ℕ) (hk : 0 < k) :
    PhysHSGaussian.sphereUniform k {x | ‖x‖ = Real.sqrt k} = 1 := by sorry
