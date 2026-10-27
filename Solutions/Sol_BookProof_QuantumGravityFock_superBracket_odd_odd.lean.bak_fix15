-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.superBracket_odd_odd
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_superBracket_apply
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {V : Type*} [AddCommGroup V] [Module ℂ V]
    (A B : V →ₗ[ℂ] V) (x : V) : superBracket 1 1 A B x = A (B x) + B (A x) := by

  rw [superBracket_apply, sgnDeg, if_pos ⟨rfl, rfl⟩]
  simp
