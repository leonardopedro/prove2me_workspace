-- Generated from ChapterHermiteGalerkinFriedrichs.lean — theorem BookProof.HermiteGalerkin.starProjection_tendsto_of_monotone_dense
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

theorem BookProof.HermiteGalerkin.starProjection_tendsto_of_monotone_dense (K : ℕ → Submodule ℂ F)
    [∀ n, (K n).HasOrthogonalProjection] (hmono : Monotone K)
    (hdense : Dense ((⨆ n : ℕ, K n : Submodule ℂ F) : Set F)) (u : F) :
    Tendsto (fun n : ℕ => (K n).starProjection u) atTop (nhds u) := by sorry
