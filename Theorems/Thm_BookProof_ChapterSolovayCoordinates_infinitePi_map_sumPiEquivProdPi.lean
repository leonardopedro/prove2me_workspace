-- Generated from ChapterSolovayCoordinates.lean — theorem BookProof.ChapterSolovayCoordinates.infinitePi_map_sumPiEquivProdPi
import Mathlib
import Definitions.Def_ChapterSolovayCoordinates
import Definitions.Def_ChapterA4
open BookProof.ChapterSolovayCoordinates


open MeasureTheory ProbabilityTheory
open scoped ENNReal

noncomputable section

theorem BookProof.ChapterSolovayCoordinates.infinitePi_map_sumPiEquivProdPi {ι ι' : Type*} [Fintype ι] {X : ι ⊕ ι' → Type*}
    [∀ i, MeasurableSpace (X i)] (mu : ∀ i, Measure (X i))
    [∀ i, IsProbabilityMeasure (mu i)] :
    Measure.map (MeasurableEquiv.sumPiEquivProdPi X) (Measure.infinitePi mu)
      = (Measure.pi fun i : ι => mu (Sum.inl i)).prod
        (Measure.infinitePi fun j : ι' => mu (Sum.inr j)) := by sorry
