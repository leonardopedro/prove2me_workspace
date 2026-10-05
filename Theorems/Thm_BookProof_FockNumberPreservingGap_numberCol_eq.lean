-- Generated from ChapterFockNumberPreservingGap.lean — theorem BookProof.FockNumberPreservingGap.numberCol_eq
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FarisLavine BookProof.NavierStokesFlow

theorem BookProof.FockNumberPreservingGap.numberCol_eq (k : ℕ) : numberCol k = Finsupp.single k (1 : ℂ) := by sorry
