-- Generated from ChapterStarobinskyPotential.lean — theorem BookProof.Starobinsky.qgR2_stone_flow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
open BookProof.EsaClosure
open BookProof.FarisLavine
open BookProof.QuantumGravityDensitized
open BookProof.StoneBridge
open BookProof.Starobinsky

variable (a b : ℕ → ℝ) (M alpha : ℝ) (Rc : ℕ → ℝ)


open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

theorem BookProof.Starobinsky.qgR2_stone_flow :
    ∃ (T : UnboundedSelfAdjoint L2Nat) (U : ℝ → (L2Nat →L[ℂ] L2Nat)),
      IsSelfAdjointExtension (qgR2ModeHamiltonian a b M alpha Rc) T.op ∧ IsStoneFlow T U := by sorry
