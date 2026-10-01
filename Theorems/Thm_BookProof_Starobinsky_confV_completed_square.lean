-- Generated from ChapterStarobinskyPotential.lean — theorem BookProof.Starobinsky.confV_completed_square
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

theorem BookProof.Starobinsky.confV_completed_square {M alpha : ℝ} (halpha : alpha ≠ 0) (Rc : ℝ) :
    confV M alpha Rc = alpha * (Rc - M ^ 2 / (4 * alpha)) ^ 2 - M ^ 4 / (16 * alpha) := by sorry
