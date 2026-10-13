-- Generated from ChapterNavierStokesDiffHashimoto.lean — solution of BookProof.NavierStokesFlow.DiffHashimoto.coreOp_id
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffHashimoto
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreOp_coreEquiv
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
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

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution {d : ℕ} :
    coreOp (LinearMap.id (R := ℂ) (M := MvPolynomial (Fin d) ℂ))
      = LinearMap.id (R := ℂ) (M := (polyGaussCore (d := d))) := by

  refine LinearMap.ext fun y => ?_
  obtain ⟨p, rfl⟩ := (coreEquiv (d := d)).surjective y
  simp [coreOp_coreEquiv]
