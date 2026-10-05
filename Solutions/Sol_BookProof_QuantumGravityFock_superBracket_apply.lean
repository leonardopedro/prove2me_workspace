-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.superBracket_apply
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {V : Type*} [AddCommGroup V] [Module ℂ V] (p q : ZMod 2)
    (A B : V →ₗ[ℂ] V) (x : V) :
    superBracket p q A B x = A (B x) - sgnDeg p q • B (A x) := rfl
