-- Generated from ChapterSolovayCoordinates.lean — solution of BookProof.ChapterSolovayCoordinates.infinitePi_map_sumPiEquivProdPi
import Mathlib
import Definitions.Def_ChapterSolovayCoordinates
import Theorems.Thm_BookProof_ChapterSolovayCoordinates_infinitePi_map_sumPiEquivProdPi_symm
open BookProof.ChapterSolovayCoordinates



open MeasureTheory ProbabilityTheory
open scoped ENNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {ι ι' : Type*} [Fintype ι] {X : ι ⊕ ι' → Type*}
    [∀ i, MeasurableSpace (X i)] (mu : ∀ i, Measure (X i))
    [∀ i, IsProbabilityMeasure (mu i)] :
    Measure.map (MeasurableEquiv.sumPiEquivProdPi X) (Measure.infinitePi mu)
      = (Measure.pi fun i : ι => mu (Sum.inl i)).prod
        (Measure.infinitePi fun j : ι' => mu (Sum.inr j)) := by

  rw [← Measure.infinitePi_eq_pi]
  exact (MeasurableEquiv.map_apply_eq_iff_map_symm_apply_eq _).2
    (infinitePi_map_sumPiEquivProdPi_symm mu).symm
