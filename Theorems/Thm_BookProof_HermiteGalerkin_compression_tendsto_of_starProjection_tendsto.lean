-- Generated from ChapterHermiteGalerkinFriedrichs.lean — theorem BookProof.HermiteGalerkin.compression_tendsto_of_starProjection_tendsto
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology

theorem BookProof.HermiteGalerkin.compression_tendsto_of_starProjection_tendsto (K : ℕ → Submodule ℂ F)
    [∀ n, (K n).HasOrthogonalProjection] (A : F →L[ℂ] F)
    (hP : ∀ u : F, Tendsto (fun n : ℕ => (K n).starProjection u) atTop (nhds u)) (u : F) :
    Tendsto (fun n : ℕ => (K n).starProjection (A ((K n).starProjection u)))
      atTop (nhds (A u)) := by sorry
