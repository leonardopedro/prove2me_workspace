-- Generated from ChapterStarobinskyPotential.lean — theorem BookProof.Starobinsky.confV_ge
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.Starobinsky











open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

theorem BookProof.Starobinsky.confV_ge {M alpha : ℝ} (halpha : 0 < alpha) (Rc : ℝ) :
    -(M ^ 4 / (16 * alpha)) ≤ confV M alpha Rc := by sorry
