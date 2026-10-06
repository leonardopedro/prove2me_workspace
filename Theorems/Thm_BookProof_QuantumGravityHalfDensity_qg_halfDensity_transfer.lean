-- Generated from ChapterQuantumGravityHalfDensity.lean — theorem BookProof.QuantumGravityHalfDensity.qg_halfDensity_transfer
import Mathlib
import Definitions.Def_ChapterQuantumGravityHalfDensity
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.QuantumGravityHalfDensity



open MeasureTheory Set Filter
open scoped ENNReal

theorem BookProof.QuantumGravityHalfDensity.qg_halfDensity_transfer
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
    (hflat : HasZeroDeficiencyOn D' H') : HasZeroDeficiencyOn D H := by sorry
