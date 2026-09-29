-- Generated from ChapterStarobinskyPotential.lean — theorem BookProof.Starobinsky.qgR2_stone_flow
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.Starobinsky


open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

theorem BookProof.Starobinsky.qgR2_stone_flow :
    ∃ (T : UnboundedSelfAdjoint L2Nat) (U : ℝ → (L2Nat →L[ℂ] L2Nat)),
      IsSelfAdjointExtension (qgR2ModeHamiltonian a b M alpha Rc) T.op ∧ IsStoneFlow T U := by sorry
