-- Generated from ChapterG3.lean — solution of BookProof.ChapterG3.mehler_uniform_concentrates
import Mathlib
import Definitions.Def_ChapterG3
open BookProof.ChapterG3



open MeasureTheory
open scoped ENNReal



variable {X : Type*}

variable {X : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (hk : 0 < k) :
    PhysHSGaussian.sphereUniform k {x | ‖x‖ = Real.sqrt k} = 1 := PhysHSGaussian.sphereUniform_sphere k hk
