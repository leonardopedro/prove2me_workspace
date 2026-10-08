-- Generated from ChapterMeasureAtomicDiffuse.lean — theorem BookProof.ChapterMeasureAtomicDiffuse.exists_atomic_diffuse_decomposition
import Mathlib
import Definitions.Def_ChapterMeasureAtomicDiffuse
open BookProof.ChapterMeasureAtomicDiffuse


noncomputable section

open MeasureTheory Complex



variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)


theorem BookProof.ChapterMeasureAtomicDiffuse.exists_atomic_diffuse_decomposition [IsFiniteMeasure mu] :
    ∃ (A : Set α) (mua mud : Measure α), A.Countable ∧ MeasurableSet A ∧
      mu = mua + mud ∧
      mua = Measure.sum (fun x : A => mu {(x : α)} • Measure.dirac (x : α)) ∧
      mua Aᶜ = 0 ∧ NullSingletonClass mud := by sorry
