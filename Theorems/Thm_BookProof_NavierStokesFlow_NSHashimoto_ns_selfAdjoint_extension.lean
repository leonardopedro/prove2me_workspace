-- Generated from ChapterNavierStokesHashimoto.lean — theorem BookProof.NavierStokesFlow.NSHashimoto.ns_selfAdjoint_extension
import Mathlib
import Definitions.Def_ChapterNavierStokesHashimoto
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.NSHashimoto

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)


open Filter Topology



open BookProof.FarisLavine BookProof.HashimotoShiftInvert BookProof.EsaClosure
open BookProof.HermiteGalerkin
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow.IkebeKato

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

theorem BookProof.NavierStokesFlow.NSHashimoto.ns_selfAdjoint_extension :
    ∃ (Dom : Submodule ℂ (L2I Vel)) (G : Dom →ₗ[ℂ] L2I Vel),
      IsSelfAdjointExtension (velCore A c) G := by sorry
