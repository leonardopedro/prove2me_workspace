-- Generated from ChapterStarobinskyPotential.lean — theorem BookProof.Starobinsky.confV_zero_alpha_tendsto_atBot
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.Starobinsky











open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

theorem BookProof.Starobinsky.confV_zero_alpha_tendsto_atBot {M : ℝ} (hM : M ≠ 0) :
    Tendsto (fun Rc => confV M 0 Rc) atTop atBot := by sorry
