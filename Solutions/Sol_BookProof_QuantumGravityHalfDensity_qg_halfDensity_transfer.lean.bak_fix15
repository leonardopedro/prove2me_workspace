-- Generated from ChapterQuantumGravityHalfDensity.lean — solution of BookProof.QuantumGravityHalfDensity.qg_halfDensity_transfer
import Mathlib
import Definitions.Def_ChapterQuantumGravityHalfDensity
import Theorems.Thm_BookProof_QuantumGravityDensitized_densitized_hasZeroDeficiencyOn_transfer
open BookProof.QuantumGravityHalfDensity




open MeasureTheory Set Filter
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution
    {D : Submodule ℂ (Lp ℂ 2 (volume.restrict (Set.Ioi (0 : ℝ))))}
    {D' : Submodule ℂ (Lp ℂ 2 qgSrcMeasure)}
    {H : D →ₗ[ℂ] D} {H' : D' →ₗ[ℂ] D'}
    (hmap : ∀ x : D, halfDensityUnitary (x : Lp ℂ 2 (volume.restrict (Set.Ioi (0 : ℝ)))) ∈ D')
    (hsurj : ∀ y : D', ∃ x : D,
      halfDensityUnitary (x : Lp ℂ 2 (volume.restrict (Set.Ioi (0 : ℝ))))
        = (y : Lp ℂ 2 qgSrcMeasure))
    (hint : ∀ x : D, (H' ⟨halfDensityUnitary (x : Lp ℂ 2 (volume.restrict (Set.Ioi (0 : ℝ)))),
        hmap x⟩ : Lp ℂ 2 qgSrcMeasure)
      = halfDensityUnitary ((H x : Lp ℂ 2 (volume.restrict (Set.Ioi (0 : ℝ))))))
    (hflat : HasZeroDeficiencyOn D' H') : HasZeroDeficiencyOn D H :=
  BookProof.QuantumGravityDensitized.densitized_hasZeroDeficiencyOn_transfer
      halfDensityUnitary hmap hsurj hint hflat
