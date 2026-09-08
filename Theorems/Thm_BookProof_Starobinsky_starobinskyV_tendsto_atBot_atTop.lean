-- Generated from ChapterStarobinskyPotential.lean — theorem BookProof.Starobinsky.starobinskyV_tendsto_atBot_atTop
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.Starobinsky











open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

theorem BookProof.Starobinsky.starobinskyV_tendsto_atBot_atTop {M alpha : ℝ} (hM : 0 < M) (halpha : 0 < alpha) :
    Tendsto (fun phi => starobinskyV M alpha phi) atBot atTop := by sorry
