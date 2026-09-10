-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.comm_lagP_lagQ_of_ne
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical

















open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato  BookProof.NavierStokesFlow.LagrangianKatoRellich
open BookProof.NavierStokesFlow.CanonicalVector BookProof.NavierStokesFlow.ThreeComponent














variable (nu : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution {i k : Fin 3} (h : i ≠ k) :
    (lagP nu i).comp (lagQ nu k) = (lagQ nu k).comp (lagP nu i) := by

  simp only [lagP, lagQ, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul,
    comm_mom_pos_of_ne h]
  rw [mul_comm]
