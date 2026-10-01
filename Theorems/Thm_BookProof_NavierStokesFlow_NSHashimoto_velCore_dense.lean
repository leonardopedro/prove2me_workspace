-- Generated from ChapterNavierStokesHashimoto.lean — theorem BookProof.NavierStokesFlow.NSHashimoto.velCore_dense
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

theorem BookProof.NavierStokesFlow.NSHashimoto.velCore_dense : Dense ((lpFiniteModes Vel : Submodule ℂ (L2I Vel)) : Set (L2I Vel)) := by sorry
