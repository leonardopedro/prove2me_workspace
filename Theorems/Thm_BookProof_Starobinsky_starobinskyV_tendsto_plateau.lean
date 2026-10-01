-- Generated from ChapterStarobinskyPotential.lean — theorem BookProof.Starobinsky.starobinskyV_tendsto_plateau
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.Starobinsky


open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.QuantumGravityDensitized BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

theorem BookProof.Starobinsky.starobinskyV_tendsto_plateau {M alpha : ℝ} (hM : 0 < M) :
    Tendsto (fun phi => starobinskyV M alpha phi) atTop (𝓝 (M ^ 4 / (16 * alpha))) := by sorry
