-- Generated from ChapterNavierStokesDiffHashimoto.lean — solution of BookProof.NavierStokesFlow.DiffHashimoto.polySym_id
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffHashimoto
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffHashimoto








open Filter Topology



open MvPolynomial
open BookProof.FarisLavine BookProof.HashimotoShiftInvert BookProof.EsaClosure
open BookProof.HermiteGalerkin
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteRelative
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution {d : ℕ} :
    BookProof.YangMillsHermite.PolySym (LinearMap.id (R := ℂ) (M := MvPolynomial (Fin d) ℂ)) := fun _ _ => rfl
