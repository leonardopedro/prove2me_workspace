-- Generated from ChapterStarobinskyPotential.lean — solution of BookProof.Starobinsky.qgR2Mode_esa
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.Starobinsky












open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section





















variable (a b : ℕ → ℝ) (M alpha : ℝ) (Rc : ℕ → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn
      (mulSymbolDomain (qgModeSymbol a b (qgR2ModePotential M alpha Rc)))
      (qgR2ModeHamiltonian a b M alpha Rc) := qgModeHamiltonian_essentiallySelfAdjoint a b (qgR2ModePotential M alpha Rc)
