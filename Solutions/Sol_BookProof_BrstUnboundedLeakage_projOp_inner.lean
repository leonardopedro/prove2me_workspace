-- Generated from ChapterBrstUnboundedLeakage.lean — solution of BookProof.BrstUnboundedLeakage.projOp_inner
import Mathlib
import Definitions.Def_ChapterBrstUnboundedLeakage
open BookProof.BrstUnboundedLeakage



open NormedSpace Filter Topology
open scoped InnerProductSpace


open BookProof.BrstLeakage BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)
variable (V : Submodule ℂ H) [FiniteDimensional ℂ V] (hV : V ≤ T.domain)

set_option maxHeartbeats 1000000 in
theorem solution (x y : H) : ⟪projOp V x, y⟫_ℂ = ⟪x, projOp V y⟫_ℂ := V.starProjection_isSymmetric x y
