-- Generated from ChapterBrstUnboundedLeakage.lean — theorem BookProof.BrstUnboundedLeakage.projOp_inner
import Definitions.Def_ChapterBrstTruncationLeakage
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterBrstUnboundedLeakage
open BookProof.BrstUnboundedLeakage

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)
variable (V : Submodule ℂ H) [FiniteDimensional ℂ V] (hV : V ≤ T.domain)


open NormedSpace Filter Topology
open scoped InnerProductSpace


open BookProof.BrstLeakage BookProof.ChapterStoneResolvent


theorem BookProof.BrstUnboundedLeakage.projOp_inner (x y : H) : ⟪projOp V x, y⟫_ℂ = ⟪x, projOp V y⟫_ℂ := by sorry
