-- Generated from ChapterStarobinskyPotential.lean — theorem BookProof.Starobinsky.confV_bddBelow
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.Starobinsky











open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

theorem BookProof.Starobinsky.confV_bddBelow {M alpha : ℝ} (halpha : 0 < alpha) :
    BddBelow (Set.range fun Rc => confV M alpha Rc) := by sorry
