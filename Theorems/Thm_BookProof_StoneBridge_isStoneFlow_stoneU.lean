-- Generated from ChapterStoneBridge.lean — theorem BookProof.StoneBridge.isStoneFlow_stoneU
import Mathlib
import Definitions.Def_ChapterStoneBridge
open BookProof.StoneBridge






open Filter Topology
open scoped InnerProductSpace


open BookProof.FarisLavine BookProof.EsaClosure BookProof.YangMillsFriedrichs
open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]










variable [CompleteSpace F]

theorem BookProof.StoneBridge.isStoneFlow_stoneU (T : UnboundedSelfAdjoint F) : IsStoneFlow T T.stoneU := by sorry
