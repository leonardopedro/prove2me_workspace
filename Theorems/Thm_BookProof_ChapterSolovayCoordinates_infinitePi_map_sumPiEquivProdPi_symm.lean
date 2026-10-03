-- Generated from ChapterSolovayCoordinates.lean — theorem BookProof.ChapterSolovayCoordinates.infinitePi_map_sumPiEquivProdPi_symm
import Mathlib
import Definitions.Def_ChapterSolovayCoordinates
import Definitions.Def_ChapterA4


open MeasureTheory ProbabilityTheory
open scoped ENNReal

noncomputable section

theorem BookProof.ChapterSolovayCoordinates.infinitePi_map_sumPiEquivProdPi_symm {ι ι' : Type*} {X : ι ⊕ ι' → Type*}
    [∀ i, MeasurableSpace (X i)] (mu : ∀ i, Measure (X i))
    [∀ i, IsProbabilityMeasure (mu i)] :
    Measure.map (MeasurableEquiv.sumPiEquivProdPi X).symm
      ((Measure.infinitePi fun i : ι => mu (Sum.inl i)).prod
        (Measure.infinitePi fun j : ι' => mu (Sum.inr j))) = Measure.infinitePi mu := by sorry
