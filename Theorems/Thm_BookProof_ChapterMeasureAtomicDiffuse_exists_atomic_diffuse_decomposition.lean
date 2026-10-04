-- Generated from ChapterMeasureAtomicDiffuse.lean — theorem BookProof.ChapterMeasureAtomicDiffuse.exists_atomic_diffuse_decomposition
import Mathlib
import Definitions.Def_ChapterMeasureAtomicDiffuse
import Definitions.Def_ChapterA4
open BookProof.ChapterMeasureAtomicDiffuse

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)


noncomputable section

open MeasureTheory Complex




theorem BookProof.ChapterMeasureAtomicDiffuse.exists_atomic_diffuse_decomposition [IsFiniteMeasure mu] :
    ∃ (A : Set α) (mua mud : Measure α), A.Countable ∧ MeasurableSet A ∧
      mu = mua + mud ∧
      mua = Measure.sum (fun x : A => mu {(x : α)} • Measure.dirac (x : α)) ∧
      mua Aᶜ = 0 ∧ NullSingletonClass mud := by sorry
